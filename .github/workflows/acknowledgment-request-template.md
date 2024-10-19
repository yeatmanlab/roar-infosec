# Generate infosec acknowledgment issues

It's time to generate infosec acknowledgement issues for all of the ROAR team.

Perform these commands on your command line:

```shell
TEAM_MEMBERS=$(gh api orgs/yeatmanlab/teams/roar/members --jq '.[].login')

for MEMBER in $TEAM_MEMBERS
do
  ISSUE_BODY="Please acknowledge that you have reviewed the Data Privacy and Information Security Manual and accompanying documents by commenting 'Acknowledged' below."
  gh issue create --title "Acknowledgment Request for $MEMBER" --body "$ISSUE_BODY" --assignee $MEMBER
done
```
