package com.videostar.vsnews.service;

/**
 * 引擎的全局监听器
 * Created by patchao2000 on 14-6-3.
 */
import org.activiti.engine.delegate.event.ActivitiEvent;
import org.activiti.engine.delegate.event.ActivitiEventListener;
import org.activiti.engine.delegate.event.ActivitiVariableEvent;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class VariableCreateListener implements ActivitiEventListener {

    protected Logger logger = LoggerFactory.getLogger(getClass());

    @Override
    public void onEvent(ActivitiEvent event) {
        switch (event.getType()) {

            case VARIABLE_CREATED:
                ActivitiVariableEvent variableEvent = (ActivitiVariableEvent) event;
                System.out.println("创建了变量: " + variableEvent.getVariableName() + ", 值：" + variableEvent.getVariableValue());
                break;

            default:
                System.out.println("Event received: " + event.getType());
        }
    }

    @Override
    public boolean isFailOnException() {
        return false;
    }
}
