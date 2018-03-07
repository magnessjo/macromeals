
import deploy from 'deploy';
import shell from 'shelljs';
import config from './config.json';
import symlink from './symlink.js';

shell.exec('webpack --env.NODE_ENV=production', { async: false }, function() {
  shell.rm('build/index.php');
  shell.rm('-rf', 'build/uploads');

  deploy.release(config);
  symlink();
});
