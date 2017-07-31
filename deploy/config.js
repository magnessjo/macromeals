
import deploy from 'deploy';
import config from './config.json';
import symlink from './symlink.js';

deploy.config(config);
symlink();
