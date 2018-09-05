part of nyxx;

/// A mini channel object for invites.
class InviteChannel extends Channel {
  /// The channel's name.
  String name;

  InviteChannel._new(Nyxx client, Map<String, dynamic> raw)
      : super._new(client, raw, raw['type'] as int) {
    this.name = raw['name'] as String;
  }

  /// Returns a string representation of this object.
  @override
  String toString() => this.name;
}
