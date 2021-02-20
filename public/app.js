const dataNode = document.querySelector('#chart-data')
const testResults = JSON.parse(dataNode.innerHTML)

const bytesToMBits = (bytes) => bytes / 1000 / 1000 * 8

const options = {
    series: [{
        name: 'Download',
        data: testResults.map(result => [result.timestamp * 1000, bytesToMBits(result["download-bandwidth-bytes"]).toFixed(2)])
    },
    {
        name: 'Upload',
        data: testResults.map(result => [result.timestamp * 1000, bytesToMBits(result["upload-bandwidth-bytes"]).toFixed(2)])
    }],
    yaxis: {
        labels: {
            // formatter: function (val) {
            //     return (val / 1000000).toFixed(0);
            // },
        },
        title: {
            text: 'Bandwidth (Mbit/s)'
        },
        min: 0,
    },
    xaxis: {
        type: 'datetime',
    },
    chart: {
        type: 'area',
        stacked: false,
        height: '60%',
    },
    title: {
        text: 'Bandwidth Speedtests',
        align: 'center'
    },
    fill: {
        type: 'gradient',
        gradient: {
        shadeIntensity: 1,
        inverseColors: false,
        opacityFrom: 0.6,
        opacityTo: 0,
        stops: [0, 90, 100]
        },
    },
    tooltip: {
        custom: function({series, seriesIndex, dataPointIndex, w}) {
            const value = series[seriesIndex][dataPointIndex]
            // TODO: somehow extract the speedtest result and display some stuff
            // TODO: display server infos
            return `<span style="color: red;">${value}</span>`
        },
    }
};

const chartNode = document.querySelector('#chart')
const chart = new ApexCharts(chartNode, options);
chart.render();
