import TopicRoute from 'discourse/routes/topic';
import { ajax } from 'discourse/lib/ajax';

export default {
  name: "tvc-router",
  after: 'message-bus',
  initialize(){
    TopicRoute.reopen({
      onOpen: function(){
        const topic = this.modelFor('topic');
        ajax('/_vcounter/track/' + topic.id + '/incr', {
          method: 'GET'
        }).then(() => {
          console.log('---------------- controller called successfully')
        }, function(msg){
          console.log('controller called unsuccessfully --------------')
        });
      }.on('activate'),
    });
  }
};
