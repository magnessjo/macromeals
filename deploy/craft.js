
import builder from 'builder';
import deploy from 'deploy';
import config from './config.json';
import symlink from './symlink.js';
import shell from 'shelljs';

const logger = builder.logger;
const Client = builder.remote;
const name = process.argv[2] || process.env.DEPLOY_TARGET || config.default;
const target = config.targets[name];
const remote = new Client(target.user, target.host, target.env);

shell.exec('rm -rf craft/storage');

remote.exec(`if [ -h ${target.destination}/craft/storage ]; then sudo unlink ${target.destination}/craft/storage; fi`);
remote.copy('craft', target.destination);
remote.exec(`sudo chmod -R 775 ${target.destination}/craft/app`);
remote.exec(`sudo chmod -R 775 ${target.destination}/craft/config`);
remote.exec(`sudo ln -s ${target.destination}/shared/storage ${target.destination}/craft`);
remote.exec(`sudo chmod -R 777 ${target.destination}/craft/storage`);

symlink();

shell.exec('mkdir craft/storage');
