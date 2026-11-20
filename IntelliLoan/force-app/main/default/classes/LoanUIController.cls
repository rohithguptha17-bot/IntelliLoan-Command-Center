public with sharing class LoanUIController {

    @AuraEnabled(cacheable=true)
    public static List<Loan_Application__c> getMyLoans() {

        return [
            SELECT Id, Loan_Amount__c, Status__c, Risk_Score__c
            FROM Loan_Application__c
            WHERE CreatedById = :UserInfo.getUserId()
            ORDER BY CreatedDate DESC
        ];
    }

    @AuraEnabled
    public static void approveLoan(Id loanId, String decision) {

        Loan_Application__c loan = [
            SELECT Id, Status__c
            FROM Loan_Application__c
            WHERE Id = :loanId
            LIMIT 1
        ];

        if (decision == 'Approve') {
            loan.Status__c = 'Approved';
        }
        else if (decision == 'Reject') {
            loan.Status__c = 'Rejected';
        }
        else {
            throw new AuraHandledException(
                'Invalid loan decision.'
            );
        }

        update loan;
    }
}