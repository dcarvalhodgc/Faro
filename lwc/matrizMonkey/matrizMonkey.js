/*-------------------------------------------------------------------------------------------------------
--- Company: Faro
--- Author: Douglas
--- Description: Classe  js componente MatrizController
    Contem todas as funçoes js do componente MatrizMonkey
--- Date: 27/06/2021 Version 1.0
-------------------------------------------------------------------------------------------------------*/
import { LightningElement, track, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import gerar from '@salesforce/apex/MatrizController.getMatriz';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class MatrizMonkey extends NavigationMixin(LightningElement) {
    @api recordId
    success = false
    resultNumero = ''
    resultCaminho = ''
    resultColunas = ''
    resultId = ''
    errorMsg = ''
    finish = false
    clicked = false
    title = 'Sucesso!'
    message = 'Matriz gerada com sucesso!'
    variant = 'success'
    variantOptions = [
      { label: 'error', value: 'error' },
      { label: 'warning', value: 'warning' },
      { label: 'success', value: 'success' },
      { label: 'info', value: 'info' }
    ]
  
    gerarMatriz() {
        gerar({ recordId: this.recordId }).then(result => {
        console.log('TYUMI => result: ' + JSON.stringify(result))
  
        this.finish = false
  
        if (result.type == 'OK') {
          this.success = true
          this.resultNumero = result.numero
          this.resultId = result.id
          this.clicked = true
          this.resultCaminho = result.caminho
          this.resultColunas = result.colunas
          this.showNotification()
      
        } else {
          this.errorMsg = result.errorMsg
          this.title = 'Erro.'
          this.message = 'Ocorreu um erro.'
          this.variant = 'error'
          this.showNotification()
        }
  
      })
  
      this.finish = true
    }
  
    navigateToRecordViewPage() {
      console.log('TYUMI => id: ' + this.recordId)
          this[NavigationMixin.Navigate]({
              type: 'standard__recordPage',
              attributes: {
                  recordId: this.resultId,
                  actionName: 'view'
              }
          });
    }
  
    showNotification() {
      const evt = new ShowToastEvent({
        title: this.title,
        message: this.message,
        variant: this.variant
      })
      this.dispatchEvent(evt)
    }
  
    get showSpinner() {
      return this.finish && !this.success
    }
  }