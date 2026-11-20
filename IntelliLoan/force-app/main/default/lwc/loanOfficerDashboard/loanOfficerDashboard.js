import { LightningElement, wire } from 'lwc';
import getMyLoans from '@salesforce/apex/LoanUIController.getMyLoans';

export default class LoanOfficerDashboard extends LightningElement {

    loans;
    columns = [
        { label: 'Loan Amount', fieldName: 'Loan_Amount__c', type: 'currency' },
        { label: 'Status', fieldName: 'Status__c' }
    ];

    @wire(getMyLoans)
    wiredLoans({ data, error }) {
        if (data) {
            this.loans = data;
        }
    }
}