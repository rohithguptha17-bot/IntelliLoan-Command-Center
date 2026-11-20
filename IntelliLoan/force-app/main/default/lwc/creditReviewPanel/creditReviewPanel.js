import { LightningElement, api } from 'lwc';
import approveLoan from '@salesforce/apex/LoanUIController.approveLoan';

export default class LoanApprovalConsole extends LightningElement {

    @api recordId;

    approve() {
        approveLoan({ loanId: this.recordId, decision: 'Approve' });
    }

    reject() {
        approveLoan({ loanId: this.recordId, decision: 'Reject' });
    }
}