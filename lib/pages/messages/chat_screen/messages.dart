import 'package:flutter/material.dart';
import 'package:sakina/core/widgets/custom_app_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'chat_screen.dart';

class ConversationsScreen extends StatefulWidget {
  const ConversationsScreen({super.key});

  @override
  State<ConversationsScreen> createState() => _ConversationsScreenState();
}

class _ConversationsScreenState extends State<ConversationsScreen> {
  final supabase = Supabase.instance.client;
  int _selectedFilter = 0;
  final List<String> _filters = ['All', 'Roommates', 'Landlords'];
  List<Map<String, dynamic>> _conversations = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadConversations();
    _subscribeToMessages();
  }

  Future<void> _loadConversations() async {
    setState(() => _isLoading = true);
    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) return;

      // جيب كل المحادثات بتاعت الـ user
      final participantRows = await supabase
          .from('conversation_participants')
          .select('conversation_id')
          .eq('user_id', userId);

      final conversationIds = (participantRows as List)
          .map((e) => e['conversation_id'] as String)
          .toList();

      if (conversationIds.isEmpty) {
        setState(() {
          _conversations = [];
          _isLoading = false;
        });
        return;
      }

      // جيب آخر message لكل conversation
      List<Map<String, dynamic>> convList = [];

      for (final convId in conversationIds) {
        // جيب الـ participants التانيين
        final otherParticipants = await supabase
            .from('conversation_participants')
            .select('user_id')
            .eq('conversation_id', convId)
            .neq('user_id', userId);

        if ((otherParticipants as List).isEmpty) continue;

        final otherUserId = otherParticipants.first['user_id'];

        // جيب بيانات الـ user التاني
        final otherUser = await supabase
            .from('users')
            .select('full_name, avatar_url')
            .eq('user_id', otherUserId)
            .maybeSingle();

        // جيب آخر message
        final lastMessages = await supabase
            .from('messages')
            .select()
            .eq('conversation_id', convId)
            .order('sent_at', ascending: false)
            .limit(1);

        // عدد الـ unread messages
        final unreadMessages = await supabase
            .from('messages')
            .select()
            .eq('conversation_id', convId)
            .eq('is_read', false)
            .neq('sender_id', userId);

        final lastMessage =
            (lastMessages as List).isNotEmpty ? lastMessages.first : null;

        convList.add({
          'conversation_id': convId,
          'other_user_id': otherUserId,
          'other_user_name': otherUser?['full_name'] ?? 'Unknown',
          'other_user_avatar': otherUser?['avatar_url'],
          'last_message': lastMessage?['content'] ?? 'No messages yet',
          'last_message_time': lastMessage?['sent_at'],
          'unread_count': (unreadMessages as List).length,
          'is_my_message': lastMessage?['sender_id'] == userId,
        });
      }

      // رتب حسب آخر message
      convList.sort((a, b) {
        if (a['last_message_time'] == null) return 1;
        if (b['last_message_time'] == null) return -1;
        return b['last_message_time'].compareTo(a['last_message_time']);
      });

      setState(() {
        _conversations = convList;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      debugPrint('Error loading conversations: $e');
    }
  }

  void _subscribeToMessages() {
    supabase
        .channel('messages_changes')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'messages',
          callback: (payload) {
            _loadConversations();
          },
        )
        .subscribe();
  }

  String _formatTime(String? timestamp) {
    if (timestamp == null) return '';
    final dt = DateTime.parse(timestamp).toLocal();
    final now = DateTime.now();
    final diff = now.difference(dt);

    if (diff.inMinutes < 60) return '${diff.inMinutes}M AGO';
    if (diff.inHours < 24) return '${diff.inHours}H AGO';
    if (diff.inDays == 1) return 'YESTERDAY';
    if (diff.inDays < 7) {
      const days = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
      return days[dt.weekday - 1];
    }
    return '${dt.day}/${dt.month}';
  }

  @override
  void dispose() {
    supabase.channel('messages_changes').unsubscribe();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Myappbar(),
      backgroundColor: const Color(0xFFF2ECDE),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildSearchBar(),
              _buildFilterTabs(),
              _isLoading
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(40),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : _conversations.isEmpty
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(40),
                            child: Text(
                              'No conversations yet',
                              style: TextStyle(
                                color: Color(0xFF7E766B),
                                fontFamily: 'Manrope',
                              ),
                            ),
                          ),
                        )
                      : Column(
                          children: _conversations
                              .map((c) => _buildConversationTile(c))
                              .toList(),
                        ),
              _buildSakinaSafetyTip(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 24, 20, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Conversations',
            style: TextStyle(
              color: Color(0xFF120A00),
              fontSize: 36,
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w600,
              height: 1.11,
              letterSpacing: -0.90,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Keep up with your potential roommates and hosts.',
            style: TextStyle(
              color: Color(0xFF4C463C),
              fontSize: 16,
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 14),
            Icon(Icons.search, color: Colors.grey[400], size: 20),
            const SizedBox(width: 8),
            Text(
              'Search messages...',
              style: TextStyle(
                color: const Color(0xFF7E766B),
                fontSize: 16,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterTabs() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Row(
        children: List.generate(_filters.length, (index) {
          final selected = _selectedFilter == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedFilter = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFF1A1A1A)
                    : const Color(0xFFEAE8E5),
                borderRadius: BorderRadius.circular(4),
                border: selected
                    ? null
                    : Border.all(color: Colors.grey[300]!, width: 1.2),
              ),
              child: Text(
                _filters[index],
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w400,
                  color: selected ? Colors.white : const Color(0xFF4C463C),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildConversationTile(Map<String, dynamic> conv) {
    final unread = conv['unread_count'] as int;
    final isMyMessage = conv['is_my_message'] as bool;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChatScreen(
              conversationId: conv['conversation_id'],
              otherUserId: conv['other_user_id'],
              otherUserName: conv['other_user_name'],
              otherUserAvatar: conv['other_user_avatar'],
            ),
          ),
        ).then((_) => _loadConversations());
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F3F0),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          leading: CircleAvatar(
            radius: 26,
            backgroundColor: Colors.grey[200],
            backgroundImage: conv['other_user_avatar'] != null
                ? NetworkImage(conv['other_user_avatar'])
                : null,
            child: conv['other_user_avatar'] == null
                ? const Icon(Icons.person, color: Colors.grey)
                : null,
          ),
          title: Text(
            conv['other_user_name'],
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14.5,
              color: Color(0xFF1A1A1A),
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Row(
              children: [
                if (isMyMessage)
                  Padding(
                    padding: const EdgeInsets.only(right: 3),
                    child:
                        Icon(Icons.done_all, size: 14, color: Colors.grey[400]),
                  ),
                Expanded(
                  child: Text(
                    conv['last_message'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
              ],
            ),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _formatTime(conv['last_message_time']),
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[400],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              if (unread > 0)
                Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1A1A1A),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$unread',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              else
                Icon(Icons.chevron_right, size: 18, color: Colors.grey[300]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSakinaSafetyTip() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8F0),
        borderRadius: BorderRadius.circular(16),
        border: const Border(
          left: BorderSide(color: Color(0xFFE8A857), width: 4),
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.shield_outlined, color: Color(0xFFE8A857), size: 20),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sakina Safety Tip',
                  style: TextStyle(
                    color: Color(0xFF3A0B00),
                    fontSize: 14,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Never share your password or bank details through chat. Always conduct transactions within our secure platform.',
                  style: TextStyle(
                    color: Color(0xFF3A0B00),
                    fontSize: 12,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
