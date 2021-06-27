/*-------------------------------------------------------------------------------------------------------
--- Company: Faro
--- Author: Douglas
--- Description: Classe Teste  MatrizController
    Contem todas as validações do componente MatrizMonkey
--- Date: 27/06/2021 Version 1.0
-------------------------------------------------------------------------------------------------------*/
@isTest
public with sharing class MatrizControllerTeste 
{    
    @TestSetup
    static void setup()
    {
        //created da matriz
        Matriz__c mat = sObjectFactory.getMatriz();       
        insert mat;
    }

    @IsTest
    static void createdMatriz()
    { 
        //Select Matriz
        Matriz__c idMatrizMonkey = [SELECT Id FROM Matriz__c  LIMIT 1];
        
        Test.startTest();
        MatrizController.Result teste = MatrizController.getMatriz(idMatrizMonkey.id);        
        Test.stopTest();
        
        //Validation if insert object and retrun result
        List<Matriz__c>  listObjectMatriz = [Select Id, Colunas__c, Resultado__c, Caminho__c 
                                                                FROM Matriz__c 
                                                                WHERE Resultado__c != '' and id =: idMatrizMonkey.id]; 

        System.assert(listObjectMatriz.size() > 0, 'Objeto nao foi criado');
        System.assertEquals(listObjectMatriz[0].Resultado__c, teste.numero);
    
    }
    
}