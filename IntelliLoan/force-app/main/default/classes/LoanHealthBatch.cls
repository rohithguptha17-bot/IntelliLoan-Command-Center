public class LoanHealthBatch
    implements Database.Batchable<SObject> {

    public Database.QueryLocator start(
        Database.BatchableContext context
    ) {
        return Database.getQueryLocator(
            'SELECT Id, Risk_Score__c FROM Loan_Application__c'
        );
    }

    public void execute(
        Database.BatchableContext context,
        List<Loan_Application__c> scope
    ) {
        for (Loan_Application__c loan : scope) {
            if (loan.Risk_Score__c >= 80) {
                loan.Status__c = 'High Risk';
            }
        }
        update scope;
    }

    public void finish(Database.BatchableContext context) {
        System.debug('Loan health audit completed.');
    }
}