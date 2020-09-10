class IdeaItem{
  String mainIdea;
  String sub;
  String ans;
  final String postId;
  final DateTime timeStamp;
  final String userId;
  final dynamic likes;
  IdeaItem({this.mainIdea, this.sub, this.ans, this.postId, this.timeStamp, this.userId, this.likes});
  factory IdeaItem.fromDocument(doc){
    return IdeaItem(
      mainIdea: doc['title'],
      sub: doc['subIdea'],
      ans: doc['body'],
      postId: doc['postId'],
      userId: doc['userId'],
      likes: doc['likes']
    );
  }
}