echo "Clone the repo..."

# TODO: Create a robot github account and make it responsible for pushing updates to the repo
rm -rf repo/
echo "https://trickypr:${deploy_acc_key}@github.com/focus-browser/repo"
git clone https://trickypr:${deploy_acc_key}@github.com/focus-browser/repo
mkdir -p repo/flatpak/alpha

echo "Building flatpak for the alpha repo"

rm -rf focus-build
flatpak-builder --repo=repo/flatpak/alpha/ --gpg-sign=856780A2B7EAC3C2AA34C1DCC210F0A67AAA29F4 ./focus-build ./com.fushra.browser.desktop.yml

echo "Commiting to the repo"

cd repo/
git add .
git commit -m "📦️ Update alpha flatpak builds"
git push origin main