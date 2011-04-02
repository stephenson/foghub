require_relative './test_helper'

class Parser < MiniTest::Unit::TestCase
  def test_parsing_commit_with_one_case_should_return_right_case
    commit = "Added awesome feature, fixes #42"
    commit = CommitParser.new(commit)

    assert_equal [42], commit.cases
  end

  def test_parsing_commit_with_more_than_one_case_should_return_all_cases
    commit = "Added awesome feature, fixes #42 and #48"
    commit = CommitParser.new(commit)

    assert_equal [42, 48], commit.cases
  end

  def test_parsing_commit_with_review_should_find_review
    commit = "Added awesome feature, fixes #42 and #48 someone should #review"
    commit = CommitParser.new(commit)

    assert commit.review?
  end

  def test_parsing_commit_with_no_review_should_not_find_review
    commit = "Added awesome feature, fixes #42 and #48"
    commit = CommitParser.new(commit)

    assert_nil commit.review?
  end

  def test_parsing_commit_with_a_reviewer_should_find_reviewer
    commit = "Added awesome feature, fixes #42 and #48 #review @sirupsen"
    commit = CommitParser.new(commit)

    assert_equal ['sirupsen'], commit.reviewers
  end

  def test_parsing_commit_with_multiple_reviews_should_find_all_reviewers
    commit = "Added awesome feature, fixes #42 and #48 #review @sirupsen @mkyed"
    commit = CommitParser.new(commit)

    assert_equal ['sirupsen', 'mkyed'], commit.reviewers
  end

  def test_parsing_commit_should_not_catch_at_as_empty_reviewer
    commit = "Added awesome feature @ admin2, fixes #42 and #48 #review @sirupsen @mkyed"
    commit = CommitParser.new(commit)

    assert_equal 2, ['sirupsen', 'mkyed'].count
  end
end
