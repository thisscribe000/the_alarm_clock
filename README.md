# The Alarm Clock

Skeleton Flutter project for an alarm clock app with:
- Alarm manager
- World clocks (add cities)
- Stopwatch
- Timer

How to run:

1. Ensure Flutter SDK is installed and on PATH.
2. From project root run:

```bash
flutter pub get
flutter run
```

To create a GitHub repo and push (if you have GitHub CLI `gh`):

```bash
# in project root
git init
git add .
git commit -m "Initial scaffold for The Alarm Clock"
# create remote and push
gh repo create the_alarm_clock --public --source=. --remote=origin --push
```

If you don't have `gh`, create a repo on GitHub and run:

```bash
git remote add origin git@github.com:YOUR_USERNAME/the_alarm_clock.git
git push -u origin main
```
