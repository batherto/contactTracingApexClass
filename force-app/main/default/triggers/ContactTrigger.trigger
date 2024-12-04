trigger ContactTrigger on Contact (after insert, after update, after delete, after undelete) {
       // now uses the trigger handler
        switch on Trigger.operationType {
            when AFTER_INSERT {
                system.debug('After_insert we will call afterInsertHandler');
                ContactTriggerHandler.afterInsertHandler();
            }
            when AFTER_UPDATE {
                system.debug('After Update we will call afterUpdateHandler');
                ContactTriggerHandler.afterUpdateHandler();
        }
            when AFTER_DELETE {
                system.debug('After Delete we will call afterDeleteHandler');
                ContactTriggerHandler.afterDeleteHandler();
            }
            when AFTER_UNDELETE {
                system.debug('After_undelete we will call afterundeleteHandler');
                ContactTriggerHandler.afterUndeleteHandler();
        }
        
    }   
}