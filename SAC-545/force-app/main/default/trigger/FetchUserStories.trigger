trigger FetchJiraUserStories on User__c (after insert) {
    // Get the list of user IDs from the inserted records
    List<Id> userIds = new List<Id>();
    for (User__c user : Trigger.new) {
        userIds.add(user.Id);
    }
    
    // Fetch the user stories from Jira API
    List<JiraUserStory__c> jiraUserStories = [SELECT Id, Title__c, Description__c, Assigned_Team_Member__c FROM JiraUserStory__c WHERE User__c IN :userIds];
    
    // Update the user stories with the user IDs
    for (JiraUserStory__c userStory : jiraUserStories) {
        userStory.User__c = userIds;
    }
    
    // Update the user stories in Salesforce
    update jiraUserStories;
}