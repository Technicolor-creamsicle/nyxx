part of nyxx;

/// Emitted when a user adds a reaction to a message.
class MessageReactionEvent {
  /// User who fired event
  User user;

  /// Channel on which event was fired
  MessageChannel channel;

  /// Message to which emojis was added
  Message message;

  /// Emoji ebject
  Emoji emoji;

  MessageReactionEvent._new(
      Nyxx client, Map<String, dynamic> json, bool added) {
    this.user = client.users[Snowflake(json['d']['user_id'] as String)];
    this.channel = client.channels[Snowflake(json['d']['channel_id'] as String)]
        as MessageChannel;

    channel
        .getMessage(Snowflake(json['d']['message_id'] as String))
        .then((msg) => message = msg);

    if (message == null) return;

    if (json['d']['emoji']['id'] == null)
      emoji = UnicodeEmoji._partial((json['d']['emoji']['name'] as String));
    else
      emoji = GuildEmoji._partial(json['d']['emoji'] as Map<String, dynamic>);

    if (added) {
      this.message._onReactionAdded.add(this);
      client._events.onMessageReactionAdded.add(this);
    } else {
      this.message._onReactionRemove.add(this);
      client._events.onMessageReactionRemove.add(this);
    }
  }
}
