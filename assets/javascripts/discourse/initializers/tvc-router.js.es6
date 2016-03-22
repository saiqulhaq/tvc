import TopicRoute from 'discourse/routes/topic'

export default {
  name: "tvc-router",
  after: 'message-bus',
  initialize(){
    TopicRoute.reopen({
      onOpen: function(){
        const topic = this.modelFor('topic');
        Discourse.ajax('/tvc/track/' + topic.id + '/incr', {
          method: 'GET'
        }).then(function(){
          this.messageBus.subscribe('/topic-viewers-' + topic.id, function(data){
            this.controllerFor('topic').setProperties({ totalViewers: data.viewers, totalViewersElClass: '' });
            console.log(data);
          }.bind(this));
        }.bind(this), function(msg){
          console.log(msg)
        })
      }.on('activate'),

      onClose: function(){
        this.leavingTopic();
      }.on('deactivate'),

      leavingTopic: function(){
        const topic = this.modelFor('topic');
        Discourse.ajax('/tvc/track/' + topic.id + '/decr', {method: 'GET'}).then(function(){
          this.messageBus.unsubscribe('/topic-viewers-' + topic.id, function(){
            console.log('unsubscribed')
          });
          this.controllerFor('topic').setProperties({ totalViewersElClass: 'hide' });
        }.bind(this), function(msg){
          console.log(msg)
        })
      },

      actions: {
        didInsertElement() {
          $(window).on('unload onbeforeunload', function() {
            this.leavingTopic();
          }.bind(this));
        }
      }
    });
  }
}
