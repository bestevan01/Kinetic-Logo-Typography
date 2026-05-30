import {useState, useEffect} from 'react';
import {read, utils} from 'xlsx';

export default function App() {
    const [isAssembled, setIsAssembled] = useState(false);
    const [isFinal, setIsFinal] = useState(false);
    const [particles, setParticles] = useState([]);

    const [namesData, setNamesData] = useState([]);
    const [priorityNames, setPriorityNames] = useState([]);
    const [isDataLoaded, setIsDataLoaded] = useState(false);
    const [config, setConfig] = useState(null);

    useEffect(() => {
        const loadData = async () => {
            try {
                let loadedConfig = {
                    spreadDuration: 10,
                    flightDuration: 7,
                    logoFadeDuration: 2.5,
                    logoWidth: 200,
                    backgroundColor: "#050a15",
                    sequentialOrder: false
                };

                try {
                    const configRes = await fetch('/config.json');
                    if (configRes.ok) {
                        loadedConfig = await configRes.json();
                    }
                } catch (e) {
                    console.warn('config.json을 찾을 수 없어 기본값을 사용합니다.');
                }
                setConfig(loadedConfig);

                const parsedNames = [];
                const parsedPriorities = [];

                const csvResponse = await fetch('/namesData.csv');
                const isCsvHtml = csvResponse.headers.get('content-type')?.includes('text/html');

                if (csvResponse.ok && !isCsvHtml) {
                    const csvText = await csvResponse.text();
                    const rows = csvText.split('\n').map(row => row.trim()).filter(row => row);

                    for (let i = 1; i < rows.length; i++) {
                        const cols = rows[i].split(',');
                        if (cols[0]) {
                            const name = cols[0].trim();
                            parsedNames.push(name);
                            if (cols[1] && cols[1].trim().toUpperCase() === 'O') {
                                parsedPriorities.push(name);
                            }
                        }
                    }
                } else {
                    const xlsxResponse = await fetch('/namesData.xlsx');
                    const isXlsxHtml = xlsxResponse.headers.get('content-type')?.includes('text/xlsx');

                    if (xlsxResponse.ok && !isXlsxHtml) {
                        const arrayBuffer = await xlsxResponse.arrayBuffer();
                        const workbook = read(arrayBuffer, {type: 'array'});

                        const firstSheetName = workbook.SheetNames[0];
                        const worksheet = workbook.Sheets[firstSheetName];
                        const rows = utils.sheet_to_json(worksheet, {header: 1});

                        for (let i = 1; i < rows.length; i++) {
                            const row = rows[i];
                            if (row && row.length > 0 && row[0]) {
                                const name = String(row[0]).trim();
                                parsedNames.push(name);
                                if (row[1] && String(row[1]).trim().toUpperCase() === 'O') {
                                    parsedPriorities.push(name);
                                }
                            }
                        }
                    } else {
                        console.error('데이터 파일을 찾을 수 없습니다. public 폴더에 namesData.csv 또는 namesData.xlsx를 넣어주세요.');
                        return;
                    }
                }

                setNamesData(parsedNames);
                setPriorityNames(parsedPriorities);
                setIsDataLoaded(true);

            } catch (error) {
                console.error('데이터 로딩 중 에러가 발생했습니다:', error);
            }
        };

        loadData();
    }, []);


    useEffect(() => {
        if (!isDataLoaded || !config) return;

        const PARTICLE_COUNT = namesData.length;
        const img = new Image();
        img.src = '/logo.png';
        img.onload = () => {
            const targetWidth = config.logoWidth;
            const targetHeight = (img.height / img.width) * targetWidth;

            const canvas = document.createElement('canvas');
            canvas.width = targetWidth;
            canvas.height = targetHeight;

            const ctx = canvas.getContext('2d');
            ctx.drawImage(img, 0, 0, targetWidth, targetHeight);

            const imageData = ctx.getImageData(0, 0, targetWidth, targetHeight).data;
            const validPixels = [];

            for (let y = 0; y < targetHeight; y += 2) {
                for (let x = 0; x < targetWidth; x += 2) {
                    const alphaIndex = (y * targetWidth + x) * 4 + 3;
                    if (imageData[alphaIndex] > 128) {
                        const r = imageData[alphaIndex - 3];
                        const g = imageData[alphaIndex - 2];
                        const b = imageData[alphaIndex - 1];

                        validPixels.push({
                            x: x - targetWidth / 2,
                            y: y - targetHeight / 2,
                            color: `rgb(${r}, ${g}, ${b})`
                        });
                    }
                }
            }

            const INITIAL_BUFFER = 1.5;
            const progressiveDelays = [];
            for (let i = 0; i < PARTICLE_COUNT; i++) {
                progressiveDelays.push(INITIAL_BUFFER + (i / PARTICLE_COUNT) * config.spreadDuration);
            }

            if (!config.sequentialOrder) {
                progressiveDelays.sort(() => Math.random() - 0.5);
            }

            const newParticles = [];
            for (let i = 0; i < PARTICLE_COUNT; i++) {
                const randomPixel = validPixels[Math.floor(Math.random() * validPixels.length)];

                const safeWidth = window.innerWidth * 0.9;
                const safeHeight = window.innerHeight * 0.9;
                const startX = (Math.random() - 0.5) * safeWidth;
                const startY = (Math.random() - 0.5) * safeHeight;

                const priorityIndex = priorityNames.indexOf(namesData[i]);
                const isPriority = priorityIndex !== -1;

                newParticles.push({
                    id: i,
                    text: namesData[i],
                    startX,
                    startY,
                    targetX: randomPixel.x,
                    targetY: randomPixel.y,
                    color: randomPixel.color,
                    isPriority,
                    delay: isPriority ? (priorityIndex * (INITIAL_BUFFER / priorityNames.length)) : progressiveDelays[i],
                });
            }

            setParticles(newParticles);

            setTimeout(() => setIsAssembled(true), 500);

            const totalAssemblyTimeMs = (INITIAL_BUFFER * 2 + config.spreadDuration + config.flightDuration + 0.5) * 1000;
            setTimeout(() => setIsFinal(true), totalAssemblyTimeMs);
        };
    }, [isDataLoaded, namesData, priorityNames, config]);

    if (!config) return null;

    return (
        <div style={{
            width: '100vw',
            height: '100vh',
            backgroundColor: config.backgroundColor,
            overflow: 'hidden',
            display: 'flex',
            justifyContent: 'center',
            alignItems: 'center',
            position: 'relative'
        }}>
            {particles.map((p) => (
                <span
                    key={p.id}
                    style={{
                        position: 'absolute',
                        color: p.color,
                        fontSize: '11px',
                        fontWeight: 'bold',
                        zIndex: p.isPriority ? 10 : 1,
                        opacity: isFinal ? 0 : (isAssembled ? 0.9 : 0),
                        transform: `translate(${isAssembled ? p.targetX : p.startX}px, ${isAssembled ? p.targetY : p.startY}px) scale(${isAssembled ? 1 : 2.5})`,
                        transition: isFinal
                            ? `transform ${config.flightDuration}s cubic-bezier(0.7, 0, 0.2, 1) ${p.delay + 1.5}s, opacity ${config.logoFadeDuration}s ease-in-out`
                            : `transform ${config.flightDuration}s cubic-bezier(0.7, 0, 0.2, 1) ${p.delay + 1.5}s, opacity 2s ease ${p.delay}s`,
                        pointerEvents: 'none',
                        whiteSpace: 'nowrap'
                    }}
                >
          {p.text}
        </span>
            ))}

            <img
                src="/logo.png"
                alt="Logo"
                style={{
                    position: 'absolute',
                    opacity: isFinal ? 1 : 0,
                    transform: `scale(1)`,
                    transition: `opacity ${config.logoFadeDuration}s ease-in-out`,
                    width: `${config.logoWidth}px`,
                    pointerEvents: 'none'
                }}
            />
        </div>
    );
}