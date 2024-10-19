# Generate infosec acknowledgment issues

It's time to generate infosec acknowledgement issues for all of the ROAR team.

Perform these commands on your command line:

```shell
TEAM_MEMBERS=$(gh api orgs/yeatmanlab/teams/roar/members --jq '.[].login')

for MEMBER in $TEAM_MEMBERS
do
  ISSUE_BODY="@$MEMBER, it is time for the quarterly review of ROAR's information security materials. Please review the Data Privacy and Information Security Manual and SDLC policies in this repository. When you are done, comment 'Confirmed' below and a bot will take care of closing this issue."
  gh issue create --title "Acknowledgment request for $MEMBER" --body "$ISSUE_BODY" --assignee $MEMBER
done
```
