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

import activity.NotificationQueue;

/**
 * NotificationReceiver is the receiving half of a NotificationQueue.  Any
 * Activity may register interest in receiving notifications by setting the
 * receive property, which makes the function thus provided a candidate for
 * being called when a notification is sent on the corresponding
 * NotificationSender.  Note that the activity scheduler internally chooses
 * which Activity receives any given notification (attempting to choose the
 * 'least busy' Activity), so for a NotificationQueue for which there are
 * multiple receivers, there is no guarantee which receiver will receive which
 * notification, and the notifications will almost certainly not be divided
 * evenly among the receivers.  The only guarantee is that for every
 * notification sent, *some* receiver will receive it.
 **/
@:final
class NotificationReceiver
{
    /**
     * Setting this property will cause the Activity which sets it to have
     * notifications called on the function provided.  The function will be
     * called back in the Activity that set the property.  If set to null, no
     * more notifications will be given to the Activity (although they may be
     * given to other Activities independently registered to receive
     * notifications).
     **/
    public var receive(null, set_receive) : Void -> Void;


    // ------------------------------------------------------------------------
    // Private implementation follows -- please ignore.
    // ------------------------------------------------------------------------

    @:allow(activity.NotificationQueue)
    private function new(mq : NotificationQueue)
    {
        mMq = mq;
    }

    private function set_receive(f : Void -> Void) : Void -> Void
    {
        mMq.setCurrentActivityReceive(f);
        return f;
    }

    private var mMq : NotificationQueue;
}
