public with sharing class GroupManagerPageController {

    public String searchString {get;set;}
    transient public List<Group> groupList {get;private set;}
    transient public List<User> userList {get;set;}

    private List<Group> searchGroups(){

        String queryString = '%'+searchString+'%';

        return new List<Group>([Select Id, Name FROM Group WHERE Type = 'Regular' AND Name LIKE: queryString ]);
    }

    public void setGroupList(){
        searchString = '';
        groupList = searchGroups();
    }

    public List<User> searchUsers(){
        String queryString = '%'+searchString+'%';

        return new List<User>([Select Id, Name FROM User]);
    }

    public void setUserList(){
        searchString ='';
        userList = searchUsers();
    }

    public GroupManagerPageController(){


    }  
    
    
}