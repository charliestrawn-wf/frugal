/*
 * Copyright 2017 Workiva
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *     http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.workiva.frugal.transport;

import org.apache.thrift.TException;

/**
 * FSubscription is a subscription to a pub/sub topic created by a scope. The
 * topic subscription is actually handled by an FSubscriberTransport, which the
 * FSubscription wraps. Each FSubscription should have its own FSubscriberTransport.
 * The FSubscription is used to unsubscribe from the topic.
 */
public final class FSubscription {

    private final String topic;
    private final FSubscriberTransport transport;

    private FSubscription(String topic, FSubscriberTransport transport) {
        this.topic = topic;
        this.transport = transport;
    }

    /**
     * Construct a new subscription. This is used only by generated
     * code and should not be called directly.
     *
     * @param topic     for the subscription.
     * @param transport for the subscription.
     *
     * @return FSubscription
     */
    public static FSubscription of(String topic, FSubscriberTransport transport) {
        return new FSubscription(topic, transport);
    }

    /**
     * Queries whether the subscription is active.
     *
     * @return True if the subscription is active.
     */
    boolean isSubscribed() {
        return transport != null && transport.isSubscribed();
    }

    /**
     * Get the subscription topic.
     *
     * @return subscription topic.
     */
    public String getTopic() {
        return topic;
    }

    /**
     * Unsubscribe from the topic.
     */
    public void unsubscribe() {
        if (transport != null) {
            transport.unsubscribe();
        }
    }

    /**
     * Unsubscribes and removes durably stored information on the broker, if applicable.
     */
    public void remove() throws TException {
        transport.remove();
    }
}
