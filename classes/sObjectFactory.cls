/*-------------------------------------------------------------------------------------------------------
--- Company: Deloitte Brasil 
--- Author: DOuglas
--- Description:  fabrica de objetos Salesforce para ser utilizada em classes de teste
--- Date: 08/08/2019
-------------------------------------------------------------------------------------------------------
--- Author: Douglas
--- Description: 
--- Date: 
-------------------------------------------------------------------------------------------------------*/
@isTest
public class sObjectFactory {

    public static Case getCase()
    {
        Case lCase = new Case();
        lCase.Origin = 'Email';
        lCase.Status = 'New';
                
        return lCase;
    }
    
    public static Contact getContact(Account aAcc)
    {
        Contact lCtt = new Contact(FirstName = 'Test', LastName = 'Contact');
        if (aAcc != null && String.isNotBlank(aAcc.Id)) lCtt.AccountId = aAcc.Id;
        return lCtt;
    }
    
    public static Matriz__c getMatriz()
    {
        Matriz__c mat = new Matriz__c(Name = 'Test');       
        return mat;
    }
    
}