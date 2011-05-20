class CommitParser
  def initialize(commit)
    @raw_commit = commit
  end

  def cases
    @cases ||= parse_cases
  end

  def review?
    @review ||= parse_review
  end

  def reviewers
    @reviewer ||= parse_reviewers
  end

  private
  def parse_cases
    # #flatten because it returns Inception arrays (arrays inside arrays)
    @raw_commit.scan(/#(\d+)/).flatten.map(&:to_i)
  end

  def parse_review
    @raw_commit.match(/#review/)
  end

  def parse_reviewers
    # INCEPTION
    @raw_commit.scan(/@(\w+)/).flatten.map(&:downcase)
  end
end
