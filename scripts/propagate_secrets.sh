cp secrets/secrets.env	android/fastlane/.env.default
cp secrets/dev.env	android/fastlane/.env.dev
cp secrets/prod.env	android/fastlane/.env.prod
cp secrets/dev.jks android/keystore/
cp secrets/prod.jks android/keystore/
cp secrets/huawei.jks android/keystore/

cp secrets/secrets.env	ios/fastlane/.env.default
cp secrets/dev.env	ios/fastlane/.env.dev
cp secrets/prod.env	ios/fastlane/.env.prod

security import ./secrets/dev_account.p12 -P {password} -A