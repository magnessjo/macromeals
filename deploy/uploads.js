
import shell from 'shelljs';
import config from './config.json';

const name = process.argv[2] || process.env.DEPLOY_TARGET || config.default;
const target = config.targets[name];
const host = target.host;

shell.exec(`scp -r source/assets/uploads ec2-user@${host}:/srv/http/macromeals/shared`);
