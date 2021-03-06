/**
 * Copyright 2015 TiVo, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/
package activity;

import activity.MessageQueue;

/**
 * MessageSender is the sending half of a MessageQueue.  It may be used to
 * send messages to the set of receivers registered to receive messages via
 * the MessageReceiver end of the MessageQueue.  For any message sent, one
 * Activity will be chosen from the set of registered receivers to receive the
 * message, although it is indeterminite which Activity will be chosen.
 **/
@:final
class MessageSender<T>
{
    /**
     * Sends a message into the message queue, to be delivered to one of the
     * listener Activities registered via the received property.  If there are
     * currently no listeners, the message is queued up to be delivered to the
     * next Activity which sets receive.
     *
     * Note that if there are no receivers for the message, it will build up
     * in an internal queue, and there is no limit enforced on how many
     * messages can queue up in this way.
     *
     * @param msg is the message to send.  This exact object will be provided
     *        to a Activity which has registered via receive, so be sure to
     *        use Mutex locking whenever the passed value could be manipulated
     *        by two Activities concurrently.
     **/
    public function send(msg : T)
    {
        mMq.send(msg);
    }

    /**
     * Clears any messages that have not yet been received, cancelling them
     * all.
     **/
    public function clear()
    {
        mMq.clear();
    }

    // ------------------------------------------------------------------------
    // Private implementation follows -- please ignore.
    // ------------------------------------------------------------------------

    @:allow(activity.MessageQueue)
    private function new(mq : MessageQueue<T>)
    {
        mMq = mq;
    }

    private var mMq : MessageQueue<T>;
}
