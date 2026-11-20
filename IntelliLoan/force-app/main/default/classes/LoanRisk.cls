public class LoanRisk implements Queueable {

    private List<Id> loanIds;

    public LoanRisk(List<Id> loanIds) {
        this.loanIds = loanIds;
    }

    public void execute(QueueableContext context) {

        List<Loan_Application__c> loans = [
            SELECT Id, Loan_Amount__c, Risk_Score__c
            FROM Loan_Application__c
            WHERE Id IN :loanIds
        ];

        for (Loan_Application__c loan : loans) {

            // Simplified risk logic
            if (loan.Loan_Amount__c != null &&
                loan.Loan_Amount__c > 5000000) {

                loan.Risk_Score__c = 80;

            } else {
                loan.Risk_Score__c = 40;
            }
        }

        if (!loans.isEmpty()) {
            update loans;
        }
    }
}