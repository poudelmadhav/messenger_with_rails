App.conversation = App.cable.subscriptions.create('ConversationChannel',
  connected: ->
  disconnected: ->
  received: (data) ->
    conversation = $('#conversations-list').find('[data-conversation-id=\'' + data['conversation_id'] + '\']')
    conversation.find('.messages-list').find('ul').append data['message']
    messages_list = conversation.find('.messages-list')
    height = messages_list[0].scrollHeight
    messages_list.scrollTop height
    return
  speak: (message) ->
    @perform 'speak', message: message
)
$(document).on 'submit', '.new_message', (e) ->
  e.preventDefault()
  values = $(this).serializeArray()
  App.conversation.speak values
  $(this).trigger 'reset'
  return