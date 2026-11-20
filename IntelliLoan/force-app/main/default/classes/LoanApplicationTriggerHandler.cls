public class LoanApplicationTriggerHandler {

    public static void handleTrigger(
        List<Loan_Application__c> newRecords,
        Map<Id, Loan_Application__c> oldMap,
        System.TriggerOperation operationType
    ) {
        switch on operationType {
            when BEFORE_INSERT {
                // Add before insert logic
            }
            when BEFORE_UPDATE {
                // Add before update logic
            }
            when AFTER_INSERT {
                // Add after insert logic
            }
            when AFTER_UPDATE {
                // Add after update logic
            }
            when else {
                // No action
            }
        }
    }
}