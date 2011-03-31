Foghub is a small tool to associate git commits (on Github) with cases in Fogbugz and ask for codereviews.

Feature plans
=============

Associate commit with case: 

    git commit -am "This is a commit #65"

Ask for codereview:

    git commit -am "This is a commit that needs review #review @user"

Ask for codereview and associate with case:

    git commit -am "This commit to case #65 needs #review by @user"

And commits can be associatet with more then one case:

    git commit -am "This commit is closing case #65 and #66"