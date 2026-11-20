public class LoanApplicationService {

    public static void beforeInsert(List<Loan_Application__c> loans) {
        for (Loan_Application__c loan : loans) {
            loan.Status__c = 'Draft';
        }
    }

    public static void beforeUpdate(
        List<Loan_Application__c> newList,
        Map<Id, Loan_Application__c> oldMap
    ) {
        for (Loan_Application__c loan : newList) {
            Loan_Application__c oldLoan = oldMap.get(loan.Id);

            if (oldLoan.Status__c == 'Draft' &&
                loan.Status__c == 'Approved') {

                loan.addError(
                    'Loan cannot be approved directly from Draft.'
                );
            }
        }
    }

    public static void afterInsert(List<Loan_Application__c> loans) {
        // Reserved for future async logic
    }

    public static void afterUpdate(
        List<Loan_Application__c> newList,
        Map<Id, Loan_Application__c> oldMap
    ) {
        List<Id> loansForRisk = new List<Id>();

        for (Loan_Application__c loan : newList) {
            Loan_Application__c oldLoan = oldMap.get(loan.Id);

            if (oldLoan.Status__c != 'Under Credit Review' &&
                loan.Status__c == 'Under Credit Review') {

                loansForRisk.add(loan.Id);
            }
        }

        if (!loansForRisk.isEmpty()) {
            System.enqueueJob(new LoanRisk(loansForRisk));
        }
    }
}