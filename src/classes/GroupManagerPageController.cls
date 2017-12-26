public with sharing class GroupManagerPageController {

    public String searchString {get;set;}
    public List<Group> groupList {get;private set;}
    public List<User> userList {get;private set;}
    public Id selectedGroupId {get; set;}

    private List<Group> searchGroups(){
        String queryString = '%'+searchString+'%';
        return new List<Group>([Select Id, Name FROM Group WHERE Type = 'Regular' AND Name LIKE: queryString ]);
    }

    public void setGroupList(){
        groupList = searchGroups();
    }

    public List<User> searchUsers(){
        return new List<User>([Select Id, Name FROM User WHERE Id in (Select UserOrGroupId from GroupMember WHERE GroupId =: selectedGroupId)]);
    }

    public void setUserList(){
        userList = searchUsers();
    }

    public GroupManagerPageController(){


    }  
    
    
}