trigger PersonTrigger on Person__c (after insert, before insert, after update, after delete, after undelete) {
    switch on Trigger.operationType {
        when BEFORE_INSERT {
            system.debug('After_insert we will call beforeInsertHandler');
            //ContactTriggerHandler.afterInsertHandler();
        }
        when AFTER_INSERT {
            system.debug('After_insert we will call afterInsertHandler');
            //ContactTriggerHandler.afterInsertHandler();
        }
        when AFTER_UPDATE {
            system.debug('After Update we will call afterUpdateHandler');
            //ContactTriggerHandler.afterUpdateHandler();
    }
        when AFTER_DELETE {
            system.debug('After Delete we will call afterDeleteHandler');
            //ContactTriggerHandler.afterDeleteHandler();
        }
        when AFTER_UNDELETE {
            system.debug('After_undelete we will call afterundeleteHandler');
            //ContactTriggerHandler.afterUndeleteHandler();
    }
    
}   
}