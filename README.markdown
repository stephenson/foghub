Foghub associates Git commits with Fogbugz cases and code reviews.

The code is under development.

Why do code reviews?
====================

[Simply read this blogpost](http://www.codinghorror.com/blog/2006/01/code-reviews-just-do-it.html).

Feature plans
=============

Associate commit with case: 

    git commit -am "This is a commit #65"

This will post a comment to case 65 on Fogbugz with the commit message that references the Git commit on Github.

Request Fogbugz code review:

    git commit -am "This is a commit that needs review #review @user"

Creates a new code review in Fogbugz and assigns it to `@user`. If you do not specify a reviewer, Foghub will simply create an unassigned code review.

Request code review and associate with case:

    git commit -am "This commit to case #65 needs #review by @user"

Will create a new code review in Fogbugz and assign it to the user specified in the commit message. Additionally, the commit message will be attached to case 65 in Fogbugz.

Commits can be associated with multiple Fogbugz cases:

    git commit -am "This commit is closing case #65 and #66"

Creates a Fogbugz comment with the commit message in case 65 and 66 linking to the commit on Github.
