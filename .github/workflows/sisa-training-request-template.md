# Generate infosec acknowledgment issues

It's time to generate SISA training issues for all of the ROAR developers.

Perform these commands on your command line:

```shell
TEAM_MEMBERS=$(gh api orgs/yeatmanlab/teams/roar-maintainers/members --jq '.[].login')

for MEMBER in $TEAM_MEMBERS
do
  ISSUE_BODY="@$MEMBER, it's time for your annual Information Security Training. Please complete a course from the [Stanford Information Security Academy](https://uit.stanford.edu/sisa/training_and_education). When you are done, confirm your training by adding a row to the sisa-training-log.md file in this repository."
  gh issue create --title "Training request for $MEMBER" --body "$ISSUE_BODY" --assignee $MEMBER
done
```
