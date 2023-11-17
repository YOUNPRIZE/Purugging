package com.puru.purugging.common.mqtt.config;

import com.puru.purugging.common.mqtt.service.MqttPublisher;
import com.puru.purugging.common.mqtt.service.MqttMessageHandler;
import org.eclipse.paho.client.mqttv3.MqttConnectOptions;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.integration.channel.DirectChannel;
import org.springframework.integration.config.EnableIntegration;
import org.springframework.integration.dsl.IntegrationFlow;
import org.springframework.integration.dsl.IntegrationFlows;
import org.springframework.integration.mqtt.core.DefaultMqttPahoClientFactory;
import org.springframework.integration.mqtt.core.MqttPahoClientFactory;
import org.springframework.integration.mqtt.inbound.MqttPahoMessageDrivenChannelAdapter;
import org.springframework.integration.mqtt.outbound.MqttPahoMessageHandler;
import org.springframework.integration.mqtt.support.DefaultPahoMessageConverter;
import org.springframework.messaging.MessageChannel;

@Configuration
@EnableIntegration
public class MqttIntegrationConfig {

    @Value("${mqtt.url}")
    private String mqttBrokerUrl; // MQTT 브로커 URL

    @Value("${mqtt.clientId}")
    private String mqttClientId;

    @Value("${mqtt.topic}")
    private String mqttTopic; // 구독할 MQTT 토픽

//    @Autowired
//    private PloggingMqttMessageHandler ploggingMqttMessageHandler;

    @Bean
    public MqttPahoClientFactory mqttClientFactory() {
        DefaultMqttPahoClientFactory factory = new DefaultMqttPahoClientFactory();
        MqttConnectOptions options = new MqttConnectOptions();
        options.setServerURIs(new String[]{mqttBrokerUrl});
        factory.setConnectionOptions(options);
        return factory;
    }

    @Bean
    public MqttPahoMessageDrivenChannelAdapter mqttInbound() {
        MqttPahoMessageDrivenChannelAdapter adapter = new MqttPahoMessageDrivenChannelAdapter(
                "inbound", mqttClientFactory(), mqttTopic);
        adapter.setCompletionTimeout(5000); // 타임아웃 설정
        adapter.setConverter(new DefaultPahoMessageConverter());
        adapter.setQos(1);
        return adapter;
    }

    @Bean
    public MessageChannel mqttInputChannel() {
        return new DirectChannel();
    }

    @Bean
    public IntegrationFlow mqttInboundFlow(MqttMessageHandler mqttMessageHandler) {
//    public IntegrationFlow mqttInboundFlow(MachineMqttMessageHandler machineMqttMessageHandler, PloggingMqttMessageHandler ploggingMqttMessageHandler) {
        return IntegrationFlows.from(mqttInbound())//MQTT 메시지를 수신
//                               .transform(Transformers.fromJson()) // MQTT 메시지를 JSON으로 변환
//                               .route("headers['request']", // 'request' 헤더 값을 기반으로 라우팅
//                                       m -> m
//                                               .subFlowMapping("machine", sf -> sf.handle(machineMqttMessageHandler))
//                                               .subFlowMapping("plogging", sf -> sf.handle(ploggingMqttMessageHandler))
//                                               .defaultOutputToParentFlow())
//                               .get();
                               .handle(mqttMessageHandler::handleMqttMessage)//MQTT 메시지를 처리
                               .get();
    }

    @Bean
    public MqttPahoMessageHandler mqttOutbound(MqttPahoClientFactory mqttClientFactory) {
        MqttPahoMessageHandler messageHandler = new MqttPahoMessageHandler("outbound", mqttClientFactory);
        messageHandler.setAsync(true); // 비동기 발행 설정
        messageHandler.setDefaultTopic("Server"); // 발행할 토픽 설정
        return messageHandler;
    }

    @Bean
    public MqttPublisher mqttPublisher(MqttPahoClientFactory mqttClientFactory) {
        return new MqttPublisher(mqttOutbound(mqttClientFactory));
    }

    @Bean
    public MessageChannel outputChannel() {
        return new DirectChannel();
    }

}
