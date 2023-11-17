package com.puru.purugging.common.mqtt.config;

import org.springframework.integration.annotation.MessagingGateway;
import org.springframework.integration.annotation.ServiceActivator;

@MessagingGateway
public interface MessageGateway {

    @ServiceActivator(inputChannel = "mqttOutboundChannel")
    void sendMessage(String message);
}
