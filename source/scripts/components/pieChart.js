
// Import

import chartJs from 'chart.js';

// Variables

const pies = Array.from(document.querySelectorAll('[data-pie]'));

// Set Text

const drawItemsValuesPlugin = {

  afterDraw: function(chartInstance, size) {

    const ctx = chartInstance.chart.ctx;

    // Default Text Settings

    ctx.font = Chart.helpers.fontString(Chart.defaults.global.defaultFontSize, 'normal', Chart.defaults.global.defaultFontFamily);
    ctx.textAlign = 'center';
    ctx.textBaseline = 'bottom';
    ctx.lineWidth = 0.3;
    ctx.fillStyle = 'white';

    chartInstance.data.datasets.forEach((dataset) => {

      for (var i = 0; i < dataset.data.length; i++) {

        const model = dataset._meta[Object.keys(dataset._meta)[0]].data[i]._model;
        const total = dataset._meta[Object.keys(dataset._meta)[0]].total;

        let radiusPercent = 1.2;

        if (Math.round(dataset.data[i] / total * 100) > 45) {
          radiusPercent = 1;
        }

        const mid_radius = model.innerRadius + (radiusPercent * model.outerRadius - model.innerRadius) / 2.2;
        const start_angle = model.startAngle;
        const end_angle = model.endAngle;
        const mid_angle = start_angle + (end_angle - start_angle) / 2;

        const mid_radius2 = 0.92 * (model.innerRadius + (2.4 * model.outerRadius - model.innerRadius) / 2);
        const fact = i % 2 == 0 ? 1.00 : 1.15;
        const x = mid_radius * fact * Math.cos(mid_angle);
        const y = mid_radius * fact * Math.sin(mid_angle);
        const myX = mid_radius2 * fact * Math.cos(mid_angle);
        const myY = mid_radius2 * fact * Math.sin(mid_angle);
        const myX2 = 0.91 * mid_radius2 * 1 * Math.cos(mid_angle);
        const myY2 = 0.91 * mid_radius2 * 1 * Math.sin(mid_angle);

        const label = chartInstance.config.data.labels[i];
        const percent = String(Math.round(dataset.data[i] / total * 100));

        let labelSize = chartInstance.width * .08;
        let percentSize = chartInstance.width * .14;
        let percentPosition = 18;
        let textAxisModify = 1;

        if (parseInt(percent) < 15) {

          labelSize = 10;
          percentSize = 12;
          percentPosition = 12;

        }

        if (label.length == 3) {
          textAxisModify = 3;
        }

        if (label.length == 4) {
          textAxisModify = 5;
        }

        // Set Text

        if (label == 'PROTEIN' && percent < 30 || percent < 15) {
          percentPosition = 5;
          textAxisModify = 0;
        } else {
          ctx.font = `${labelSize}px acumin-pro-condensed`;
          ctx.fillText(label, model.x + x, model.y + y);
        }

        ctx.font = `bold ${labelSize}px acumin-pro`;
        ctx.textAlign = 'center';
        ctx.fillText(`${percent}%`, model.x + x + textAxisModify, model.y + y + percentPosition);

      }

    });

  }

}

// Create Pie Chart

function create(element) {

  const attributes = element.getAttribute('data-pie');
  const parts = attributes.split(',');
  const height = element.height / 2;
  const width = element.width / 2;
  let domData = [];

  parts.forEach((value, i) => {
    domData.push(parseInt(value));
  });

  chartJs.defaults.global.animation.duration = 0;
  chartJs.defaults.global.legend.display = false;
  chartJs.defaults.global.responsive = true;
  chartJs.defaults.global.tooltips.enabled = false;
  // chartJs.defaults.global.onResize = resize;

  if (element.getAttribute('data-print') == 'true') {
    chartJs.defaults.global.responsive = false;
  }

  chartJs.pluginService.register(drawItemsValuesPlugin);

  const chart = new chartJs(element, {
    type: 'pie',
    data: {
      datasets: [{
        data: domData,
        options: {
        },
        backgroundColor: [
          'rgba(144, 66, 63, 1)',
          'rgba(101, 147, 49, 1)',
          'rgba(49, 87, 125, 1'
        ],
        hoverBackgroundColor: [
          'rgba(144, 66, 63, 1)',
          'rgba(101, 147, 49, 1)',
          'rgba(49, 87, 125, 1'
        ],
        borderWidth: [1, 1, 1]
      }],
      labels: [
        'PROTEIN',
        'CARB',
        'FAT'
      ]
    },
  });

}

// Export

export default function() {

  pies.forEach((chart) => { create(chart) });

}
