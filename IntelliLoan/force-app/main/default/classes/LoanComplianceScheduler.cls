public class LoanComplianceScheduler
    implements Schedulable {

    public void execute(SchedulableContext context) {
        Database.executeBatch(new LoanHealthBatch(), 200);
    }
}