import TopicController from 'discourse/controllers/topic'


export default {
  name: "tvc-controller",
  after: 'message-bus',
  initialize(){
    TopicController.reopen({
      totalViewersElClass: 'hide',
      totalViewers: 0
    });
  }
}
