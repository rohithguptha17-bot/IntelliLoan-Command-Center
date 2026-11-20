public class SystemErrorLogger {
    public static void logError(
        String className,
        String methodName,
        Exception e
    ) {
        try {
            System_Error_Log__c log = new System_Error_Log__c();
            log.Class_Name__c = className;
            log.Method_Name__c = methodName;
            log.Error_Message__c = e.getMessage();
            log.Stack_Trace__c = e.getStackTraceString();
            log.Severity__c = 'Critical';
            log.User__c = UserInfo.getUserId();

            insert log;
        } catch (Exception loggingException) {
            // Never throw from logger
            System.debug('Logging failed: ' + loggingException.getMessage());
        }
    }
}