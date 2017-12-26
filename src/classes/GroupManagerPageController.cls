public with sharing class GroupManagerPageController {

    public List<User> userList { get; private set;}
    public List<Group> groupList { get;  private set;}

    private List<User> getUserList(){


        return new List<User>([Select Id, Name FROM User]);
    }

    private List<Group> getGroupList(){

        return new List<Group>([Select Id, Name FROM Group WHERE Type = 'Regular']);
    }

    public GroupManagerPageController(){

        userList = getUserList();
        groupList = getGroupList();

    }

    
    
    
}