# Parser of incoming events
module EventParser

  def github_create(payload)
    # TODO: get author and trim down payload
    {
      event_type: 'create',
      author: 'unknown',
      data: payload
    }
  end
end