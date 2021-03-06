# vforce_group_manager
Making a simple group manager page for fun with visualforce and apex. I had previously run into issues when I needed to add some deactivated users to a group for custom reporting in a vforce page with an apex controller. Apparently, SF doesn't want you adding Deactivated users to groups through the GUI in Setup. You can get around this by opening your browser inspector and changing the selected user IDs within the multi-picklist (tutorial below), but this is not intuitive if you have many inactive users to add. SF doesn't appear to have server-side validation on the Edit Group page to prevent deactivated users from being added to a group - only client-side validation which can be bypassed. This is just going to be a fun proof of concept to get around having to use the Inspection tool. It appears that it cannot be bypassed with Apex through DML/GroupMember insertions, but the following screenshot will show you how to get around it.

You <strong>CANNOT</strong> yet bypass the validation using this visualforce page/apex, but <strong>you CAN bypass it with the following guide at the bottom.</strong>
The code is currently functional as a basic group management tool for "Regular" type Public Groups.
You can search for a group name in whole or in part.
You can remove users from the group.
You can add users to the group.
This <strong>WILL</strong> break if your results return 1000 users or groups, since I have not yet implemented pagination. 



<strong>How to Add an InActive User to a Public Group within SF:</strong>
1. Copy inactive UserID
2. Navigate to Public Groups
3. Select Group you wish to add the inactive user to
4. Choose any user who is not currently in the group
5. With the selection arrow keys, move that user into the "Selected" section on the right as if you wanted to add them to the group
6. Right-click the user you just added to the right-hand column, and select "Inspect" if in Chrome. If in another browser, you will want to inspect on that user element that you just moved and double check against the screenshot
7. Replace the "value" after the "U:" with the inactive UserID - please refer to the image for guidance on which specific element/value to replace
8. Press the "enter" key and ensure that UserID is now set within that inspection window
9. Press Save and doublecheck that the user has been added. That user may not appear on the following screen unless you choose "View All"

![alt text](https://raw.githubusercontent.com/whats-a-handle/vforce_group_manager/master/src/img/inactive_user_group_bypass.png)
