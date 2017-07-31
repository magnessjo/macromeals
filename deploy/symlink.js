
import deploy from 'deploy';
import config from './config.json';

export default function () {

  deploy.symlink(config, [
    {
      path: 'shared',
      source: 'uploads',
      dest: 'current',
    },
    {
      path: 'config',
      source: 'index.php',
      dest: 'current',
    },
  ]);

}
