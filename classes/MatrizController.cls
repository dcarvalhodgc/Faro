/*-------------------------------------------------------------------------------------------------------
--- Company: Faro
--- Author: Douglas
--- Description: Classe MatrizController
    Contem todas as funçoes do componente MatrizMonkey
--- Date: 27/06/2021 Version 1.0
-------------------------------------------------------------------------------------------------------*/
public with sharing class MatrizController {
    
     
    private static final String OK  = 'OK';
    private static final String NOK = 'NOK';
    
    
    public MatrizController(){}


    @AuraEnabled
    public static MatrizController.Result getMatriz(id recordId)
    {
        system.debug('ID MAtriz '+recordId);
     
        MatrizController.Result result = new MatrizController.Result();
        List<integer> Coluna0 = new List<integer>();
        List<integer> Coluna1 = new List<integer>();
        List<integer> Coluna2 = new List<integer>();        
        integer numeroLinhas = 3; //Math.round(Math.random()*10);  
        Map<integer,List<integer>> mapMatriz = new Map<integer,List<integer>>();     
     
        Matriz__c matrizMonkey = [select Id, Colunas__c, Resultado__c, Caminho__c from Matriz__c  where id =: recordId limit 1];
		integer resultado = 0;
        string caminho = '';
        string colum1 = '';        
        string columFull = '';
        integer numMaior;        

        for(integer i =0; i< numeroLinhas; i++)
        {
            Coluna0.add(Math.round(Math.random()*9));
            Coluna1.add(Math.round(Math.random()*9));
            Coluna2.add(Math.round(Math.random()*9));            
        }
   

        mapMatriz.put(0,Coluna0);
        mapMatriz.put(1,Coluna1); 
        mapMatriz.put(2,Coluna2); 
     
        for(integer i =0; i< mapMatriz.size(); i++)
        {
            numMaior = 0;
            colum1 ='';
            for(integer mat : mapMatriz.get(i))
            {
                     
                if(colum1 != '')  colum1 = string.valueOf(colum1) + ';'+ string.valueOf(mat);
                if(colum1 == '') colum1 =  colum1 + string.valueOf(mat);                       
                if( mat >= numMaior) numMaior = mat;
                 
            }
            columFull = columFull + i +'= '+'('+ colum1+') ' ;
            resultado = numMaior + resultado;
            system.debug('Caminho mais rapido '+ numMaior);
            caminho =  caminho +  +'('+i +';'+numMaior+ ')'+' ' ;
           
        }

        system.debug('Numero de linhas '+numeroLinhas);
        system.debug('Matriz '+columFull);       
        system.debug('Caminho '+caminho);       
        system.debug('Resultado '+string.valueOf(resultado));      
        
        matrizMonkey.Resultado__c = string.valueOf(resultado);
        matrizMonkey.Colunas__c = columFull;        
        matrizMonkey.Caminho__c = caminho;
        
        Savepoint sp = Database.setSavepoint();

        try 
        {
            
            update matrizMonkey;
		
    	    result.type = MatrizController.OK;
            result.id = matrizMonkey.id;
            result.numero = matrizMonkey.Resultado__c;     
            result.colunas = matrizMonkey.Colunas__c;   
            result.caminho = matrizMonkey.Caminho__c; 
           
			
        } catch(Exception ex)
        {
            System.debug('MatrizController Exception: ' + ex.getMessage() + '\n\n' + ex.getStackTraceString());
            result.type = MatrizController.NOK;
            result.errorMsg = ex.getMessage();
            Database.rollback(sp);
        }
        
        System.debug('resultado --- '+ result);
        return result;        
    }


    public class Result
    {
        @AuraEnabled public String type;
        @AuraEnabled public String errorMsg;
        @AuraEnabled public String id;
        @AuraEnabled public String numero;
        @AuraEnabled public String colunas;
        @AuraEnabled public String caminho;
    }
}