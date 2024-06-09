1. A user creates a new chat, by selecting the participants who will
be involved, and optionally setting a title.

2. If the user doesn't set a title, it should be generated from the
date and the participants.

3. When a user sends a message to the chat, it adds the message to the chat.

4. After a message has been sent to the chat, fire off a job to
process that chat with every participant.

5. When the participant responses get added to the chat, the chat view
should re-draw.
