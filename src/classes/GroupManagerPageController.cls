public with sharing class GroupManagerPageController {

    public String searchString {get;set;}
    public List<Group> groupList {get;private set;}
    public List<User> memberList {get;private set;}
    public List<User> nonMemberList{get; private set;}
    public Id selectedGroupId {get; set;}
    public Id selectedUserId {get; set;}

    private void resetLists(){
        groupList.clear();
        memberList.clear();
        nonMemberList.clear();
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

        return new List<User>([Select Id, Name FROM User WHERE Id in (Select UserOrGroupId FROM GroupMember WHERE GroupId =: selectedGroupId)]);
    }

    public void setMemberList(){
        memberList = searchUsersInGroup();
        
    }
    public List<User> searchUsersNotInGroup(){

        return new List<User>([Select Id, Name FROM User WHERE Id NOT in (Select UserOrGroupId FROM GroupMember WHERE GroupId =: selectedGroupId)]);
    }

    public void setNonMemberList(){
        nonMemberList = searchUsersNotInGroup();
        system.Debug(nonMemberList);
    }

    public void searchUsers(){
        setMemberList();
        setNonMemberList();

    }
     private void refreshQueries(){
        setGroupList();
        setMemberList();
        setNonMemberList();
    }

    public void removeFromGroup(){
        GroupMember memberToRemove = [Select UserOrGroupId FROM GroupMember WHERE UserOrGroupId =: selectedUserId];
        database.delete(memberToRemove);
        refreshQueries();
    }

    public GroupManagerPageController(){
        groupList = new List<Group>();
        memberList = new List<User>();
        nonMemberList = new List<User>();
    }  
    
    
}