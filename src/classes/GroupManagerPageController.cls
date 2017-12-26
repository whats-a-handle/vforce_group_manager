public with sharing class GroupManagerPageController {

    public String searchString {get;set;}
    public List<Group> groupList {get;private set;}
    public List<User> userList {get;private set;}
    public Id selectedGroupId {get; set;}
    public Id selectedUserId {get; set;}

    private void resetLists(){
        groupList.clear();
        userList.clear();
    }

    private List<Group> searchGroups(){
        resetLists();
        String queryString = '%'+searchString+'%';

        return new List<Group>([Select Id, Name FROM Group WHERE Type = 'Regular' AND Name LIKE: queryString ]);
    }

    public void setGroupList(){
        groupList = searchGroups();
    }

    private List<User> searchUsersInGroup(){

        return new List<User>([Select Id, Name FROM User WHERE Id in (Select UserOrGroupId from GroupMember WHERE GroupId =: selectedGroupId)]);
    }

    public void setUserList(){
        userList = searchUsersInGroup();
    }

     private void refreshQueries(){
        setGroupList();
        setUserList();
    }

    public void removeFromGroup(){
        GroupMember memberToRemove = [Select UserOrGroupId FROM GroupMember WHERE UserOrGroupId =: selectedUserId];
        database.delete(memberToRemove);
        refreshQueries();
    }

    public GroupManagerPageController(){
        groupList = new List<Group>();
        userList = new List<User>();
    }  
    
    
}