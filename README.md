# paper-trail-gem-tutorial

Example app to try out paper trail gem.

Based on the following blog post:
https://stevepolito.design/blog/paper-trail-gem-tutorial/

Testing the following:
- How to use the paper trail association tracking gem
- How to restore associations more than one level deep
- How to restore an active storage attachment
- Restoring a record & all its associations (including attachments) at once
  - i.e. restoring a deleted plan restores the associated comments, notes, &
    note images
- Using jsonb instead of yaml for `object` & `object_changes` columns

Associations are set up as follows:
- An article has many comments
- A comment has many notes
- A note has many note images
- A note image has one active storage attachment linked to it
